Return-Path: <bpf+bounces-13370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738777D8B96
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 00:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2CEB21494
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FDA3F4CB;
	Thu, 26 Oct 2023 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqA2I/jk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683013D99D;
	Thu, 26 Oct 2023 22:17:55 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24168D47;
	Thu, 26 Oct 2023 15:17:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4084095722aso11038155e9.1;
        Thu, 26 Oct 2023 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698358671; x=1698963471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6aQzvymgnykTJYyUNqos0M7PldrCbODsxg27QrFdA8=;
        b=MqA2I/jk26INgZxxsfVwUbIFNkompGVlAukrf7za5JwMkk0rE5JqLiWst0keoAtdcg
         wPDrNVF6A1TCMXqSaBcOdf0YvWxoxDZuQyeqnsbFiQoX6ZvBb7TyYF8vJUzH62RRDYnd
         yd5L2Znfv+pvHvGdB4g03bhFhXNl9yDKz0loSiyC8ppi7q+DZDKYQhCHl7WTGiOZvYr7
         nb+N3uUMFacjIG3UUEt6rYExk0I9M8dpu1zrG5PHZPGEsYVd0HscdJU2kA6jnT8yNqkL
         a7QX0aK5wmvuzFNok4B4ZLYi7qsRFDyhmBxsyZTSmLJMNNXmZGUFygtJnIc+MsvvIpcK
         MImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698358671; x=1698963471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6aQzvymgnykTJYyUNqos0M7PldrCbODsxg27QrFdA8=;
        b=iJT1grZxiBrWILOARyUcxAl56GlPRsw9z0Lr0W42iYcQagSDNvNJyFpUQ9HFCJUWip
         4ug48x9jEpl3D2q8uRCjUd7CczyBcphb8k3RBDrUSsQNOmIrDdfqsX8UoRF75dNbxzuj
         0GZsVqz0KW1Vns+xPKK8wqB0ElKVZTJcJ1zpef8R68rRTSKVGaBMEjwSKdtxrtrwtiXt
         3IdkykgocQ0WIW6yqu/2cNAqI9TK4B+oXeM9YynyApO56gEWq1M/vaXhclgS7Aq70tkC
         NbjOmqTcjZcMXtYy7Aw41qKtl8dTefLQeS4+BE1r1kX9puUU8ut1Bh7qzUfTgGAIs2aB
         JHig==
X-Gm-Message-State: AOJu0YyjYiud9Fp5YMbn4Z6vnDEQ9XInMDo06MQT/Tuf5bUaTp+K3rZf
	qJ4u4hVQuJz2u2IM37W3CYM=
X-Google-Smtp-Source: AGHT+IEXk7wu+BWH5PuNjLGzYfglJqQqyr64jFKw9mM2T6j/NSdcIcGUsTFFoYUci+YzMymGrg+hrA==
X-Received: by 2002:a05:600c:1d18:b0:408:4475:8cc1 with SMTP id l24-20020a05600c1d1800b0040844758cc1mr930072wms.35.1698358671120;
        Thu, 26 Oct 2023 15:17:51 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c428300b0040596352951sm3541734wmc.5.2023.10.26.15.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:17:50 -0700 (PDT)
Date: Fri, 27 Oct 2023 01:17:45 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Justin Stitt <justinstitt@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Louis Peens <louis.peens@corigine.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Ronak Doshi <doshir@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
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
	UNGLinuxDriver@microchip.com, Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org,
	oss-drivers@corigine.com, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH next v2 3/3] treewide: Convert some ethtool_sprintf() to
 ethtool_puts()
Message-ID: <20231026221745.uiqvn6avvcruyafx@skbuf>
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-3-0d67cbdd0538@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-ethtool_puts_impl-v2-3-0d67cbdd0538@google.com>

On Thu, Oct 26, 2023 at 09:56:09PM +0000, Justin Stitt wrote:
> This patch converts some basic cases of ethtool_sprintf() to
> ethtool_puts().
> 
> The conversions are used in cases where ethtool_sprintf() was being used
> with just two arguments:
> |       ethtool_sprintf(&data, buffer[i].name);
> or when it's used with format string: "%s"
> |       ethtool_sprintf(&data, "%s", buffer[i].name);
> which both now become:
> |       ethtool_puts(&data, buffer[i].name);
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/net/dsa/lantiq_gswip.c                     |  2 +-
>  drivers/net/dsa/mt7530.c                           |  2 +-
>  drivers/net/dsa/qca/qca8k-common.c                 |  2 +-
>  drivers/net/dsa/realtek/rtl8365mb.c                |  2 +-
>  drivers/net/dsa/realtek/rtl8366-core.c             |  2 +-
>  drivers/net/dsa/vitesse-vsc73xx-core.c             |  8 +--
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c      |  4 +-
>  drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |  2 +-
>  drivers/net/ethernet/freescale/fec_main.c          |  4 +-
>  .../net/ethernet/fungible/funeth/funeth_ethtool.c  |  8 +--
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
>  .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
>  drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 65 +++++++++++-----------
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  6 +-
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  3 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c       |  9 +--
>  drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  2 +-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c       |  6 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c       |  6 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  5 +-
>  .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |  2 +-
>  .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 44 +++++++--------
>  drivers/net/ethernet/pensando/ionic/ionic_stats.c  |  4 +-
>  drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |  2 +-
>  drivers/net/hyperv/netvsc_drv.c                    |  4 +-
>  drivers/net/phy/nxp-tja11xx.c                      |  2 +-
>  drivers/net/phy/smsc.c                             |  2 +-
>  drivers/net/vmxnet3/vmxnet3_ethtool.c              | 10 ++--
>  28 files changed, 100 insertions(+), 112 deletions(-)

What's the "next" branch that you expect this to be applied through, and
why is the patch "treewide"? It only affects networking drivers (I see
nothing outside of drivers/net/) - so it's "net: Convert ..." and it
should go through the "net-next.git" tree. The patch should be formatted
as "PATCH net-next" not "PATCH next", to make this absolutely clear.

