Return-Path: <bpf+bounces-14016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441AD7DFB23
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 20:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54FA281D36
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E97219F0;
	Thu,  2 Nov 2023 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ibpfBYhI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3FE21366;
	Thu,  2 Nov 2023 19:56:57 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59EE19A;
	Thu,  2 Nov 2023 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AW0JKODqEk596T2QEg4UZ2eLMTRAd63PvmKSuulbUwQ=; b=ibpfBYhILmLn39D7AlH28340n3
	XLifNeoA3ngYepC9tqOP+n25UgJ1gaMVEaLMugYVPXmyavS2HYTe/AHVSWTa01L5LFC1qPjw1Htk/
	2KXsfghHYH4qrb5QS8256r06TCsUgebHwiX4EfUC7HcUBDNGaBmBPJBfX0AHR3/ikaTQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qydn8-000mGi-5t; Thu, 02 Nov 2023 20:55:46 +0100
Date: Thu, 2 Nov 2023 20:55:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Kiyanovski, Arthur" <akiyano@amazon.com>
Cc: Justin Stitt <justinstitt@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Arinzon, David" <darinzon@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	"GR-Linux-NIC-Dev@marvell.com" <GR-Linux-NIC-Dev@marvell.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Louis Peens <louis.peens@corigine.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	"drivers@pensando.io" <drivers@pensando.io>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Ronak Doshi <doshir@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: Convert some ethtool_sprintf() to
 ethtool_puts()
Message-ID: <0df2daf8-9707-4859-b4c2-5c3c2ef2f8cd@lunn.ch>
References: <20231102-ethtool_puts_impl-v4-0-14e1e9278496@google.com>
 <20231102-ethtool_puts_impl-v4-3-14e1e9278496@google.com>
 <75bf36b5eef9487794c11a45cb25f155@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75bf36b5eef9487794c11a45cb25f155@amazon.com>

> > + vmxnet3_rq_driver_stats[i].desc);
> >         }
> > 
> >         for (i = 0; i < ARRAY_SIZE(vmxnet3_global_stats); i++)
> > -               ethtool_sprintf(&buf, vmxnet3_global_stats[i].desc);
> > +               ethtool_puts(&buf, vmxnet3_global_stats[i].desc);
> >  }
> > 
> >  netdev_features_t vmxnet3_fix_features(struct net_device *netdev,
> > 
> > --
> > 2.42.0.869.gea05f2083d-goog
> 
> Thanks for submitting this.
> For ENA driver
> 
> Acked-by: Arthur Kiyanovski <akiyano@amazon.com> 

Hi Arthur

Please trim emails when replying.

       Andrew

