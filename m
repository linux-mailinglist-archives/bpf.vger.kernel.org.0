Return-Path: <bpf+bounces-13517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596C7DA31E
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 00:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75598B215E8
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 22:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106241203;
	Fri, 27 Oct 2023 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDl9gxkM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5782405D7
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 22:05:41 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94C11B9
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 15:05:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cc433782so22893217b3.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698444336; x=1699049136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dv2Z7o3QSlnoiZIAJzWPTX30Lbv8sYbyZygvDJ17kQQ=;
        b=EDl9gxkMlqeO0JLkWzUrzLta4iv4EsX6DA+tQ3yjltexNLB5LG+Y8EtIwSkEFU7MS8
         V73mGjGV0wcJRQ1Wr2oGuZy2Q2QKono9OrVSm5E9x/UAON5fGytV+mivZJe8ovKkS/jO
         4fE17/aT4YY+Xfe7UWcSD2yjsZmJ8fzWjyj36zL6D8zDwtGPkpOrFXoGbSDAJTKPlYmf
         MYp0pcikbN+YewmqODJLUmOBwFhx3oPbmuvFJRjZAro4T4sB31jg0E3s296+F0t6BUjz
         F8HeTQNXF0qnnoT4G9ZLlLR7VdXxZE3xyrgZ71m49+CMHvXwzk0BAx8Iycx3igy9/Gco
         SirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698444336; x=1699049136;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dv2Z7o3QSlnoiZIAJzWPTX30Lbv8sYbyZygvDJ17kQQ=;
        b=dkfvU38uYYT1nb+0xlpQAsg8w1g734Sm9Gf1+LTPgxmhM5txkDT+Nfq18u1K0Eg8c9
         hu4+de7tRKG4jCTIFusFMvnf0kuHszdZ/nrBGbpdD7ITU9aQ4yl3DwXVQotRG4q2x+Jg
         s+CTUkqXE7jcsXvR7uF1nha+tzZwQZ/DPyg/ndF/NuiNqbb034DoEVtgJdBM+7tLSWP3
         MTMqh2CWVINop/CaLFD017Re+/tVESdQkfcFhEuybELhygJ/c1McGPFfMTXjtDUeucRv
         J80Tn050vNwMsbe0C4DxwDhn3m0epIUZVN0+N+02QeMKZPwN1f0Is6f0kcXyPv/4F2P+
         aKoQ==
X-Gm-Message-State: AOJu0YzYfzhxCGFAAxoAKN08DqFx6ObbWcGbqCGWRolku3NVJ9yn5Lgr
	rOsPGd6Y+f3ntE1dVyViYRLx68xucSlAjCHdeg==
X-Google-Smtp-Source: AGHT+IGeOuhH4Qv7Tv+/RmZAun5ezMVb+qGUOXub4qqns87IuLiZmpAchyTZJzuzKeSwHNPwFLLJF23wvIsws1o0Gg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:eb0d:0:b0:5a7:db29:40e3 with SMTP
 id u13-20020a0deb0d000000b005a7db2940e3mr84362ywe.7.1698444336009; Fri, 27
 Oct 2023 15:05:36 -0700 (PDT)
Date: Fri, 27 Oct 2023 22:05:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACw0PGUC/33N3QrCIBwF8FcJrzP8aLN11XtEDKf/bcKmQ00WY
 ++eeFUQXR4O53c2FMAbCOh62JCHZIJxNgd+PCA1SjsANjpnxAjjlLAKQxyjc1O7PGNozbxMWNK
 zaPq+UwIIyrvFQ2/WYt6RhYgtrBE9cjOaEJ1/lbNES//HTRQTXMuKy4Zr3gl2G5wbJjgpNxcus U+i/kWwTBBdC9VpTSp++SL2fX8DVESAuAABAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698444334; l=4680;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=px7MMfAPCHs9L+k8HsFUFoi5x+cbpRDX4XcJD0qS6R8=; b=NAhjtgJJ6+Y49IBRLk6KB5tBlLL/NGqEIsylUEZ99sS6MgNGq/HE45sD9d4q3WquHfXSAT6bI
 pquVxl/nMnlD+d2nF4oUgCHRsmyN5haWAPvfGRi5IAtydxknzRS7y6c
X-Mailer: b4 0.12.3
Message-ID: <20231027-ethtool_puts_impl-v3-0-3466ac679304@google.com>
Subject: [PATCH net-next v3 0/3] ethtool: Add ethtool_puts()
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
Changes in v3:
- fix force_speed_maps merge conflict + formatting (thanks Vladimir)
- rebase onto net-next (thanks Andrew, Vladimir)
- change subject (thanks Vladimir)
- fix checkpatch formatting + implementation (thanks Joe)
- Link to v2: https://lore.kernel.org/r/20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com

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
      net: Convert some ethtool_sprintf() to ethtool_puts()

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
 include/linux/ethtool.h                            | 13 +++++
 net/ethtool/ioctl.c                                |  7 +++
 scripts/checkpatch.pl                              | 19 +++++++
 31 files changed, 139 insertions(+), 112 deletions(-)
---
base-commit: 3a04927f8d4b7a4f008f04af41e31173002eb1ea
change-id: 20231025-ethtool_puts_impl-a1479ffbc7e0

Best regards,
--
Justin Stitt <justinstitt@google.com>


