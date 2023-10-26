Return-Path: <bpf+bounces-13361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D287D8AED
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA85E28217B
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3933E483;
	Thu, 26 Oct 2023 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgWFsIon"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A513D989
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:56:16 +0000 (UTC)
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADC291
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:56:14 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6cf61d80fafso1768925a34.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698357374; x=1698962174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gwxImxb5RLH8OL3B8MAUHnS9LkcjmuszpBarjHsX6aA=;
        b=RgWFsIonjGuaKss2kJ7m9jje10dNl/YJv7NaqVWizvtEE9oEuykBJN7fXuihu7PlvZ
         t74xDBwmOqlFmWeEujN+bR99Ski/IXlG8g+b8kRJjmsmvK/TyzpHuRSJPdrwtCUEpNdl
         ejOLv6pUFvkyODdhFU+EPAhmLu/C7n0W9f0bItwaZq7jMP7r7roEu8GmY4hJgmVRd4/D
         UFPUwXk1tJys47FSJcoTiQLJPaGl/rgkSWvTtrAwmf6Nnl0G8Sw8fc+Zj2VEpl9kFydI
         TJJ2lLGn9yzrFsSmscGR+4JymjAy8JhFSWtFRPhr/UVXzk4DNk9iKZCbiEYrv5mcJRTg
         H8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698357374; x=1698962174;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwxImxb5RLH8OL3B8MAUHnS9LkcjmuszpBarjHsX6aA=;
        b=Yon/HVD2lEMHlw9bsfpGYfRvJXVATN0TrajzGDpOvXYwM4yjgqsfeLBxyMUveLMdL9
         h5YkJet4qBjOM/rGlGfc2wYYWg5EwV7yxP+u5jmLBycam5j0Wy4lPpUtrv1PVaR5O4Uo
         AMGh2xZZEhb94BJswnz9dRD5TkXge2pqx0AAWDqCuCTtGmb6ulDPO/ovw9uueqZp+K5V
         xADdIBK2cXagMigRgVoRhomFP0L/DBg6IjBdtIvtA55s6MMx+rpEp/TSZMc3/TG9QLyp
         6fi9MWdDDTpS1/nVIXH0X6r8lsKOLVD6tt8gJ69Khp5Gmn8NtLsgWq96BIkryQ67rW4N
         RmTw==
X-Gm-Message-State: AOJu0YyG37zEeugMgnllB+HcJQ7QJdjr+INmvZnvvVkdvebS4N7fgTe0
	T3q4Eusm561t5mAEdzxGOi8EtBm1G3HNuZIIxQ==
X-Google-Smtp-Source: AGHT+IHuXfBeHuh2fX/Y9P8Jed9OYgg7W3aDTalU6lHHqRyoYhupQv6dysAhVbsXsQm4ZlWRI0+3yNMnmE7nQTcWSA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6830:4863:b0:6bc:ce86:20bd with
 SMTP id dx3-20020a056830486300b006bcce8620bdmr145125otb.7.1698357373819; Thu,
 26 Oct 2023 14:56:13 -0700 (PDT)
Date: Thu, 26 Oct 2023 21:56:06 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHfgOmUC/32NXQqDMBCEryL73JT81Ip98h5FJOqqC+qGJBWLe
 PcGD9DHb4b55oCAnjDAKzvA40aBeE2gbxl0k11HFNQnBi21UVLnAuMUmefGfWJoaHGzsOpRlMP
 QdgVKSDvncaD9cr5hxT1CndKJQmT/vY42dXV/nJsSUjxtbmxpetMWuhqZxxnvHS9Qn+f5A1met uu5AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698357372; l=4361;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=EZQlqjeEntj5cFwO6GI9jdpBEdboCVbH85bMhi+VXog=; b=Wvnt8258jSja8OkGW51MkkX+Rpzp76iqKXSvCgM5ODfnW8jb2N0rjVr/xWqewdj9pjdMT2fDu
 L9TXUPrVOavBryg3ZKrVPnteeICUAm+k0GnhL8/NG0ZI/VctNl20MW4
X-Mailer: b4 0.12.3
Message-ID: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
Subject: [PATCH next v2 0/3] ethtool: Add ethtool_puts()
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"=?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?=" <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, 
	Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	"=?utf-8?q?Alvin_=C5=A0ipraga?=" <alsi@bang-olufsen.dk>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	UNGLinuxDriver@microchip.com, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org, 
	oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	bpf@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Hi,

This series aims to implement ethtool_puts() and send out a wave 1 of
conversions from ethtool_sprintf(). There's also a checkpatch patch
included to check for the cases listed below.

This was sparked from recent discussion here [1]

The conversions are used in cases where ethtool_sprintf() was being used
with just two arguments:
|       ethtool_sprintf(&data, buffer[i].name);
or when it's used with format string: "%s"
|       ethtool_sprintf(&data, "%s", buffer[i].name);
which both now become:
|       ethtool_puts(&data, buffer[i].name);

The first case commonly triggers a -Wformat-security warning with Clang
due to potential problems with format flags present in the strings [3].

The second is just a bit weird with a plain-ol' "%s".

v2 (and newer) of this patch is targeted at linux-next so that we can
catch some of the patches I sent [2] using this "%s" pattern and replace
them before they hit mainline.

Changes found with Cocci [4] and grep [5].

[1]: https://lore.kernel.org/all/202310141935.B326C9E@keescook/
[2]: https://lore.kernel.org/all/?q=dfb%3Aethtool_sprintf+AND+f%3Ajustinstitt
[3]: https://lore.kernel.org/all/202310101528.9496539BE@keescook/
[4]: (script authored by Kees w/ modifications from Joe)
@replace_2_args@
expression BUF;
expression VAR;
@@

-       ethtool_sprintf(BUF, VAR)
+       ethtool_puts(BUF, VAR)

@replace_3_args@
expression BUF;
expression VAR;
@@

-       ethtool_sprintf(BUF, "%s", VAR)
+       ethtool_puts(BUF, VAR)

-       ethtool_sprintf(&BUF, "%s", VAR)
+       ethtool_puts(&BUF, VAR)

[5]: $ rg "ethtool_sprintf\(\s*[^,)]+\s*,\s*[^,)]+\s*\)"

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- wrap lines better in replacement (thanks Joe, Kees)
- add --fix to checkpatch (thanks Joe)
- clean up checkpatch formatting (thanks Joe, et al.)
- rebase against next
- Link to v1: https://lore.kernel.org/r/20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com

---
Justin Stitt (3):
      ethtool: Implement ethtool_puts()
      checkpatch: add ethtool_sprintf rules
      treewide: Convert some ethtool_sprintf() to ethtool_puts()

 drivers/net/dsa/lantiq_gswip.c                     |  2 +-
 drivers/net/dsa/mt7530.c                           |  2 +-
 drivers/net/dsa/qca/qca8k-common.c                 |  2 +-
 drivers/net/dsa/realtek/rtl8365mb.c                |  2 +-
 drivers/net/dsa/realtek/rtl8366-core.c             |  2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  8 +--
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |  4 +-
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |  2 +-
 drivers/net/ethernet/freescale/fec_main.c          |  4 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |  8 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 65 +++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  6 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  3 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  9 +--
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  5 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |  2 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 44 +++++++--------
 drivers/net/ethernet/pensando/ionic/ionic_stats.c  |  4 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |  2 +-
 drivers/net/hyperv/netvsc_drv.c                    |  4 +-
 drivers/net/phy/nxp-tja11xx.c                      |  2 +-
 drivers/net/phy/smsc.c                             |  2 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              | 10 ++--
 include/linux/ethtool.h                            | 34 +++++++----
 net/ethtool/ioctl.c                                |  7 +++
 scripts/checkpatch.pl                              | 19 +++++++
 31 files changed, 149 insertions(+), 123 deletions(-)
---
base-commit: 2ef7141596eed0b4b45ef18b3626f428a6b0a822
change-id: 20231025-ethtool_puts_impl-a1479ffbc7e0

Best regards,
--
Justin Stitt <justinstitt@google.com>


