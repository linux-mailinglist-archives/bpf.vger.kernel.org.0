Return-Path: <bpf+bounces-16951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BD0807C2E
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 00:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FE21C20BD1
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAD8328AD;
	Wed,  6 Dec 2023 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7FtWOg+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F4A10C2
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 15:16:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d340a9cf07so468637b3.3
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 15:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701904578; x=1702509378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVka6SFD0txo+FDSY9W25V6pLOZXiB86yP6d1Pt82Es=;
        b=c7FtWOg+KMDqbJQY5oxEUPkWHUqR6KUbIdUOcVbD3In+Hn23NszlwszIp54sPfmhDc
         xfkPvbigb3KI/W+XlIKqWF6vWFdOijlfksfjriQiDrYftbU5DPSo00LGsOtx8qJ64Ikx
         Oyt+W4C/XFPtefuVNT0TfqDFX4N+4rXJLFFmThT7hF4npEBGb8r6StXJh2djOB/sNHx6
         xhdPTYQwLR7EXNnZinXczMXmIdVmTEvCMEUI+Jl//yNCV0fcYZSpN6SRQKu84rcXFkGV
         DsoyHpWeDgYhWTBvvwkEZxyhnDBsPYb4/YtNZzAvpSWC/bhk1uglIIqGHc4aRvzP6+oV
         aSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701904578; x=1702509378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVka6SFD0txo+FDSY9W25V6pLOZXiB86yP6d1Pt82Es=;
        b=pZqUkwfIW3pt6NbPBFrIVnDEvw5V0kjAvsYcCQiLfM3tL+eJ/mPbA6ntjhccEJ3Uom
         YT4e87LKKldF8YgmcuevU22N94bsY7L4/t+e2eGBcE0fc2MCQ3anXoEpTZMVQuC2AUi1
         cKX3GPRYolbViCnPPMXDcdglhuVBIGKGHnB29SIX9mDVG12XQEQuNOgOfj/GLFIeHCt0
         hN5nI3/GpyHHkiP9aMmDMhOrlQeK0aHKhwACb3VOc6n9jk3nxN1ozmKftYo1YSpkXQ5d
         O/FrFSLlnh+XuPmL/aLUjlyvQd6OhZZqYLETfsvLZqZ4RsE805HoI8q3Fufdy9lF/6JF
         C0dA==
X-Gm-Message-State: AOJu0YwTPBVxFIgOl+hBimE48vSC2JQlHkZy1c/ovlQL6ljdEpFFc38E
	0TXS7tUxBk30T2wgnq3aEFg59y7j4sqKGdD4Bw==
X-Google-Smtp-Source: AGHT+IEkasdYj28UlvP/bZ8lDFKBlATQVTdOXql+z16vI5P6TdcHOUWZ+FbJPeVYBf+q7zOLG+ilQ3dBc+SoFAnTYg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:e68a:0:b0:dbc:3003:a135 with SMTP
 id d132-20020a25e68a000000b00dbc3003a135mr7609ybh.13.1701904578358; Wed, 06
 Dec 2023 15:16:18 -0800 (PST)
Date: Wed, 06 Dec 2023 23:16:12 +0000
In-Reply-To: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701904573; l=28898;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=N2eHALMRUvWN/+VgQ5GCQKcdQDk3Z4Su4gN4VRGeXBs=; b=i4UVlEK187DFRiFJEl6Nppsc+Rg+Aj37zkVCS7q8ODqKfAKLpx4gHuAApxrvA8zLnrsc/Pf8J
 qXvCF4mjYFwDouk3P6KAirU/nq+xtrVc6C6E3NzbxSjqiNbYUXQJ/1u
X-Mailer: b4 0.12.3
Message-ID: <20231206-ethtool_puts_impl-v5-3-5a2528e17bf8@google.com>
Subject: [PATCH net-next v5 3/3] net: Convert some ethtool_sprintf() to ethtool_puts()
From: justinstitt@google.com
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

This patch converts some basic cases of ethtool_sprintf() to
ethtool_puts().

The conversions are used in cases where ethtool_sprintf() was being used
with just two arguments:
|       ethtool_sprintf(&data, buffer[i].name);
or when it's used with format string: "%s"
|       ethtool_sprintf(&data, "%s", buffer[i].name);
which both now become:
|       ethtool_puts(&data, buffer[i].name);

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
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
 28 files changed, 100 insertions(+), 112 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 9c185c9f0963..05a017c9ef3d 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1759,7 +1759,7 @@ static void gswip_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(gswip_rmon_cnt); i++)
-		ethtool_sprintf(&data, "%s", gswip_rmon_cnt[i].name);
+		ethtool_puts(&data, gswip_rmon_cnt[i].name);
 }
 
 static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d27c6b70a2f6..391c4dbdff42 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -836,7 +836,7 @@ mt7530_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(mt7530_mib); i++)
-		ethtool_sprintf(&data, "%s", mt7530_mib[i].name);
+		ethtool_puts(&data, mt7530_mib[i].name);
 }
 
 static void
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 9243eff8918d..2358cd399c7e 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -487,7 +487,7 @@ void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < priv->info->mib_count; i++)
-		ethtool_sprintf(&data, "%s", ar8327_mib[i].name);
+		ethtool_puts(&data, ar8327_mib[i].name);
 }
 
 void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 0875e4fc9f57..b072045eb154 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1303,7 +1303,7 @@ static void rtl8365mb_get_strings(struct dsa_switch *ds, int port, u32 stringset
 
 	for (i = 0; i < RTL8365MB_MIB_END; i++) {
 		struct rtl8365mb_mib_counter *mib = &rtl8365mb_mib_counters[i];
-		ethtool_sprintf(&data, "%s", mib->name);
+		ethtool_puts(&data, mib->name);
 	}
 }
 
diff --git a/drivers/net/dsa/realtek/rtl8366-core.c b/drivers/net/dsa/realtek/rtl8366-core.c
index 82e267b8fddb..59f98d2c8769 100644
--- a/drivers/net/dsa/realtek/rtl8366-core.c
+++ b/drivers/net/dsa/realtek/rtl8366-core.c
@@ -401,7 +401,7 @@ void rtl8366_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < priv->num_mib_counters; i++)
-		ethtool_sprintf(&data, "%s", priv->mib_counters[i].name);
+		ethtool_puts(&data, priv->mib_counters[i].name);
 }
 EXPORT_SYMBOL_GPL(rtl8366_get_strings);
 
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index e6f29e4e508c..dd50502e2122 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -949,7 +949,7 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	indices[5] = ((val >> 26) & 0x1f); /* TX counter 2 */
 
 	/* The first counters is the RX octets */
-	ethtool_sprintf(&buf, "RxEtherStatsOctets");
+	ethtool_puts(&buf, "RxEtherStatsOctets");
 
 	/* Each port supports recording 3 RX counters and 3 TX counters,
 	 * figure out what counters we use in this set-up and return the
@@ -959,15 +959,15 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	 */
 	for (i = 0; i < 3; i++) {
 		cnt = vsc73xx_find_counter(vsc, indices[i], false);
-		ethtool_sprintf(&buf, "%s", cnt ? cnt->name : "");
+		ethtool_puts(&buf, cnt ? cnt->name : "");
 	}
 
 	/* TX stats begins with the number of TX octets */
-	ethtool_sprintf(&buf, "TxEtherStatsOctets");
+	ethtool_puts(&buf, "TxEtherStatsOctets");
 
 	for (i = 3; i < 6; i++) {
 		cnt = vsc73xx_find_counter(vsc, indices[i], true);
-		ethtool_sprintf(&buf, "%s", cnt ? cnt->name : "");
+		ethtool_puts(&buf, cnt ? cnt->name : "");
 
 	}
 }
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index d671df4b76bc..e3ef081aa42b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -299,13 +299,13 @@ static void ena_get_strings(struct ena_adapter *adapter,
 
 	for (i = 0; i < ENA_STATS_ARRAY_GLOBAL; i++) {
 		ena_stats = &ena_stats_global_strings[i];
-		ethtool_sprintf(&data, ena_stats->name);
+		ethtool_puts(&data, ena_stats->name);
 	}
 
 	if (eni_stats_needed) {
 		for (i = 0; i < ENA_STATS_ARRAY_ENI(adapter); i++) {
 			ena_stats = &ena_stats_eni_strings[i];
-			ethtool_sprintf(&data, ena_stats->name);
+			ethtool_puts(&data, ena_stats->name);
 		}
 	}
 
diff --git a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
index df10edff5603..d1ad6c9f8140 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
@@ -608,7 +608,7 @@ bnad_get_strings(struct net_device *netdev, u32 stringset, u8 *string)
 
 	for (i = 0; i < BNAD_ETHTOOL_STATS_NUM; i++) {
 		BUG_ON(!(strlen(bnad_net_stats_strings[i]) < ETH_GSTRING_LEN));
-		ethtool_sprintf(&string, bnad_net_stats_strings[i]);
+		ethtool_puts(&string, bnad_net_stats_strings[i]);
 	}
 
 	bmap = bna_tx_rid_mask(&bnad->bna);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c3b7694a7485..bae9536de767 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2932,10 +2932,10 @@ static void fec_enet_get_strings(struct net_device *netdev,
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ARRAY_SIZE(fec_stats); i++) {
-			ethtool_sprintf(&data, "%s", fec_stats[i].name);
+			ethtool_puts(&data, fec_stats[i].name);
 		}
 		for (i = 0; i < ARRAY_SIZE(fec_xdp_stat_strs); i++) {
-			ethtool_sprintf(&data, "%s", fec_xdp_stat_strs[i]);
+			ethtool_puts(&data, fec_xdp_stat_strs[i]);
 		}
 		page_pool_ethtool_stats_get_strings(data);
 
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
index 31aa185f4d17..091c93bd7587 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
@@ -655,7 +655,7 @@ static void fun_get_strings(struct net_device *netdev, u32 sset, u8 *data)
 						i);
 		}
 		for (j = 0; j < ARRAY_SIZE(txq_stat_names); j++)
-			ethtool_sprintf(&p, txq_stat_names[j]);
+			ethtool_puts(&p, txq_stat_names[j]);
 
 		for (i = 0; i < fp->num_xdpqs; i++) {
 			for (j = 0; j < ARRAY_SIZE(xdpq_stat_names); j++)
@@ -663,7 +663,7 @@ static void fun_get_strings(struct net_device *netdev, u32 sset, u8 *data)
 						xdpq_stat_names[j], i);
 		}
 		for (j = 0; j < ARRAY_SIZE(xdpq_stat_names); j++)
-			ethtool_sprintf(&p, xdpq_stat_names[j]);
+			ethtool_puts(&p, xdpq_stat_names[j]);
 
 		for (i = 0; i < netdev->real_num_rx_queues; i++) {
 			for (j = 0; j < ARRAY_SIZE(rxq_stat_names); j++)
@@ -671,10 +671,10 @@ static void fun_get_strings(struct net_device *netdev, u32 sset, u8 *data)
 						i);
 		}
 		for (j = 0; j < ARRAY_SIZE(rxq_stat_names); j++)
-			ethtool_sprintf(&p, rxq_stat_names[j]);
+			ethtool_puts(&p, rxq_stat_names[j]);
 
 		for (j = 0; j < ARRAY_SIZE(tls_stat_names); j++)
-			ethtool_sprintf(&p, tls_stat_names[j]);
+			ethtool_puts(&p, tls_stat_names[j]);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
index 8f391e2adcc0..bdb7afaabdd0 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -678,7 +678,7 @@ static void hns_gmac_get_strings(u32 stringset, u8 *data)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(g_gmac_stats_string); i++)
-		ethtool_sprintf(&buff, g_gmac_stats_string[i].desc);
+		ethtool_puts(&buff, g_gmac_stats_string[i].desc);
 }
 
 static int hns_gmac_get_sset_count(int stringset)
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
index fc26ffaae620..c58833eb4830 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
@@ -752,7 +752,7 @@ static void hns_xgmac_get_strings(u32 stringset, u8 *data)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(g_xgmac_stats_string); i++)
-		ethtool_sprintf(&buff, g_xgmac_stats_string[i].desc);
+		ethtool_puts(&buff, g_xgmac_stats_string[i].desc);
 }
 
 /**
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index b54f3706fb97..fe40cceb0f79 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -912,42 +912,41 @@ static void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	if (stringset == ETH_SS_TEST) {
 		if (priv->ae_handle->phy_if != PHY_INTERFACE_MODE_XGMII)
-			ethtool_sprintf(&buff,
-					hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
-		ethtool_sprintf(&buff,
-				hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
+			ethtool_puts(&buff,
+				     hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
+		ethtool_puts(&buff, hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
 		if ((netdev->phydev) && (!netdev->phydev->is_c45))
-			ethtool_sprintf(&buff,
-					hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
+			ethtool_puts(&buff,
+				     hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
 
 	} else {
-		ethtool_sprintf(&buff, "rx_packets");
-		ethtool_sprintf(&buff, "tx_packets");
-		ethtool_sprintf(&buff, "rx_bytes");
-		ethtool_sprintf(&buff, "tx_bytes");
-		ethtool_sprintf(&buff, "rx_errors");
-		ethtool_sprintf(&buff, "tx_errors");
-		ethtool_sprintf(&buff, "rx_dropped");
-		ethtool_sprintf(&buff, "tx_dropped");
-		ethtool_sprintf(&buff, "multicast");
-		ethtool_sprintf(&buff, "collisions");
-		ethtool_sprintf(&buff, "rx_over_errors");
-		ethtool_sprintf(&buff, "rx_crc_errors");
-		ethtool_sprintf(&buff, "rx_frame_errors");
-		ethtool_sprintf(&buff, "rx_fifo_errors");
-		ethtool_sprintf(&buff, "rx_missed_errors");
-		ethtool_sprintf(&buff, "tx_aborted_errors");
-		ethtool_sprintf(&buff, "tx_carrier_errors");
-		ethtool_sprintf(&buff, "tx_fifo_errors");
-		ethtool_sprintf(&buff, "tx_heartbeat_errors");
-		ethtool_sprintf(&buff, "rx_length_errors");
-		ethtool_sprintf(&buff, "tx_window_errors");
-		ethtool_sprintf(&buff, "rx_compressed");
-		ethtool_sprintf(&buff, "tx_compressed");
-		ethtool_sprintf(&buff, "netdev_rx_dropped");
-		ethtool_sprintf(&buff, "netdev_tx_dropped");
-
-		ethtool_sprintf(&buff, "netdev_tx_timeout");
+		ethtool_puts(&buff, "rx_packets");
+		ethtool_puts(&buff, "tx_packets");
+		ethtool_puts(&buff, "rx_bytes");
+		ethtool_puts(&buff, "tx_bytes");
+		ethtool_puts(&buff, "rx_errors");
+		ethtool_puts(&buff, "tx_errors");
+		ethtool_puts(&buff, "rx_dropped");
+		ethtool_puts(&buff, "tx_dropped");
+		ethtool_puts(&buff, "multicast");
+		ethtool_puts(&buff, "collisions");
+		ethtool_puts(&buff, "rx_over_errors");
+		ethtool_puts(&buff, "rx_crc_errors");
+		ethtool_puts(&buff, "rx_frame_errors");
+		ethtool_puts(&buff, "rx_fifo_errors");
+		ethtool_puts(&buff, "rx_missed_errors");
+		ethtool_puts(&buff, "tx_aborted_errors");
+		ethtool_puts(&buff, "tx_carrier_errors");
+		ethtool_puts(&buff, "tx_fifo_errors");
+		ethtool_puts(&buff, "tx_heartbeat_errors");
+		ethtool_puts(&buff, "rx_length_errors");
+		ethtool_puts(&buff, "tx_window_errors");
+		ethtool_puts(&buff, "rx_compressed");
+		ethtool_puts(&buff, "tx_compressed");
+		ethtool_puts(&buff, "netdev_rx_dropped");
+		ethtool_puts(&buff, "netdev_tx_dropped");
+
+		ethtool_puts(&buff, "netdev_tx_timeout");
 
 		h->dev->ops->get_strings(h, stringset, buff);
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index fd7163128c4d..79c3e7968a85 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2514,13 +2514,11 @@ static void i40e_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 	u8 *p = data;
 
 	for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++)
-		ethtool_sprintf(&p, "%s",
-				i40e_gstrings_priv_flags[i].flag_string);
+		ethtool_puts(&p, i40e_gstrings_priv_flags[i].flag_string);
 	if (pf->hw.pf_id != 0)
 		return;
 	for (i = 0; i < I40E_GL_PRIV_FLAGS_STR_LEN; i++)
-		ethtool_sprintf(&p, "%s",
-				i40e_gl_gstrings_priv_flags[i].flag_string);
+		ethtool_puts(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
 }
 
 static void i40e_get_strings(struct net_device *netdev, u32 stringset,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 6f236d1a6444..75d433dc1974 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -396,8 +396,7 @@ static void iavf_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 	unsigned int i;
 
 	for (i = 0; i < IAVF_PRIV_FLAGS_STR_LEN; i++)
-		ethtool_sprintf(&data, "%s",
-				iavf_gstrings_priv_flags[i].flag_string);
+		ethtool_puts(&data, iavf_gstrings_priv_flags[i].flag_string);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a34083567e6f..98c9317581e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1142,8 +1142,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ICE_VSI_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					ice_gstrings_vsi_stats[i].stat_string);
+			ethtool_puts(&p, ice_gstrings_vsi_stats[i].stat_string);
 
 		if (ice_is_port_repr_netdev(netdev))
 			return;
@@ -1162,8 +1161,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 			return;
 
 		for (i = 0; i < ICE_PF_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					ice_gstrings_pf_stats[i].stat_string);
+			ethtool_puts(&p, ice_gstrings_pf_stats[i].stat_string);
 
 		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
 			ethtool_sprintf(&p, "tx_priority_%u_xon.nic", i);
@@ -1179,8 +1177,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 		break;
 	case ETH_SS_PRIV_FLAGS:
 		for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
-			ethtool_sprintf(&p, "%s",
-					ice_gstrings_priv_flags[i].name);
+			ethtool_puts(&p, ice_gstrings_priv_flags[i].name);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 52ea38669f85..bf58989a573e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -532,7 +532,7 @@ static void idpf_add_stat_strings(u8 **p, const struct idpf_stats *stats,
 	unsigned int i;
 
 	for (i = 0; i < size; i++)
-		ethtool_sprintf(p, "%s", stats[i].stat_string);
+		ethtool_puts(p, stats[i].stat_string);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 16d2a55d5e17..89dac7b215e5 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2356,11 +2356,9 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					igb_gstrings_stats[i].stat_string);
+			ethtool_puts(&p, igb_gstrings_stats[i].stat_string);
 		for (i = 0; i < IGB_NETDEV_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					igb_gstrings_net_stats[i].stat_string);
+			ethtool_puts(&p, igb_gstrings_net_stats[i].stat_string);
 		for (i = 0; i < adapter->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 785eaa8e0ba8..2ed92bf34059 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -773,11 +773,9 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					igc_gstrings_stats[i].stat_string);
+			ethtool_puts(&p, igc_gstrings_stats[i].stat_string);
 		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					igc_gstrings_net_stats[i].stat_string);
+			ethtool_puts(&p, igc_gstrings_net_stats[i].stat_string);
 		for (i = 0; i < adapter->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 4dd897806fa5..dd722b0381e0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1413,12 +1413,11 @@ static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
 	switch (stringset) {
 	case ETH_SS_TEST:
 		for (i = 0; i < IXGBE_TEST_LEN; i++)
-			ethtool_sprintf(&p, "%s", ixgbe_gstrings_test[i]);
+			ethtool_puts(&p, ixgbe_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IXGBE_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					ixgbe_gstrings_stats[i].stat_string);
+			ethtool_puts(&p, ixgbe_gstrings_stats[i].stat_string);
 		for (i = 0; i < netdev->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index 37d2584b48a7..a06dc5a9b355 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1012,7 +1012,7 @@ static void sparx5_get_sset_strings(struct net_device *ndev, u32 sset, u8 *data)
 		return;
 
 	for (idx = 0; idx < sparx5->num_ethtool_stats; idx++)
-		ethtool_sprintf(&data, "%s", sparx5->stats_layout[idx]);
+		ethtool_puts(&data, sparx5->stats_layout[idx]);
 }
 
 static void sparx5_get_sset_data(struct net_device *ndev,
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index e75cbb287625..1636ce61a3c0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -800,7 +800,7 @@ static void nfp_get_self_test_strings(struct net_device *netdev, u8 *data)
 
 	for (i = 0; i < NFP_TEST_TOTAL_NUM; i++)
 		if (nfp_self_test[i].is_supported(netdev))
-			ethtool_sprintf(&data, nfp_self_test[i].name);
+			ethtool_puts(&data, nfp_self_test[i].name);
 }
 
 static int nfp_get_self_test_count(struct net_device *netdev)
@@ -852,24 +852,24 @@ static u8 *nfp_vnic_get_sw_stats_strings(struct net_device *netdev, u8 *data)
 		ethtool_sprintf(&data, "rvec_%u_tx_busy", i);
 	}
 
-	ethtool_sprintf(&data, "hw_rx_csum_ok");
-	ethtool_sprintf(&data, "hw_rx_csum_inner_ok");
-	ethtool_sprintf(&data, "hw_rx_csum_complete");
-	ethtool_sprintf(&data, "hw_rx_csum_err");
-	ethtool_sprintf(&data, "rx_replace_buf_alloc_fail");
-	ethtool_sprintf(&data, "rx_tls_decrypted_packets");
-	ethtool_sprintf(&data, "hw_tx_csum");
-	ethtool_sprintf(&data, "hw_tx_inner_csum");
-	ethtool_sprintf(&data, "tx_gather");
-	ethtool_sprintf(&data, "tx_lso");
-	ethtool_sprintf(&data, "tx_tls_encrypted_packets");
-	ethtool_sprintf(&data, "tx_tls_ooo");
-	ethtool_sprintf(&data, "tx_tls_drop_no_sync_data");
-
-	ethtool_sprintf(&data, "hw_tls_no_space");
-	ethtool_sprintf(&data, "rx_tls_resync_req_ok");
-	ethtool_sprintf(&data, "rx_tls_resync_req_ign");
-	ethtool_sprintf(&data, "rx_tls_resync_sent");
+	ethtool_puts(&data, "hw_rx_csum_ok");
+	ethtool_puts(&data, "hw_rx_csum_inner_ok");
+	ethtool_puts(&data, "hw_rx_csum_complete");
+	ethtool_puts(&data, "hw_rx_csum_err");
+	ethtool_puts(&data, "rx_replace_buf_alloc_fail");
+	ethtool_puts(&data, "rx_tls_decrypted_packets");
+	ethtool_puts(&data, "hw_tx_csum");
+	ethtool_puts(&data, "hw_tx_inner_csum");
+	ethtool_puts(&data, "tx_gather");
+	ethtool_puts(&data, "tx_lso");
+	ethtool_puts(&data, "tx_tls_encrypted_packets");
+	ethtool_puts(&data, "tx_tls_ooo");
+	ethtool_puts(&data, "tx_tls_drop_no_sync_data");
+
+	ethtool_puts(&data, "hw_tls_no_space");
+	ethtool_puts(&data, "rx_tls_resync_req_ok");
+	ethtool_puts(&data, "rx_tls_resync_req_ign");
+	ethtool_puts(&data, "rx_tls_resync_sent");
 
 	return data;
 }
@@ -943,13 +943,13 @@ nfp_vnic_get_hw_stats_strings(u8 *data, unsigned int num_vecs, bool repr)
 	swap_off = repr * NN_ET_SWITCH_STATS_LEN;
 
 	for (i = 0; i < NN_ET_SWITCH_STATS_LEN; i++)
-		ethtool_sprintf(&data, nfp_net_et_stats[i + swap_off].name);
+		ethtool_puts(&data, nfp_net_et_stats[i + swap_off].name);
 
 	for (i = NN_ET_SWITCH_STATS_LEN; i < NN_ET_SWITCH_STATS_LEN * 2; i++)
-		ethtool_sprintf(&data, nfp_net_et_stats[i - swap_off].name);
+		ethtool_puts(&data, nfp_net_et_stats[i - swap_off].name);
 
 	for (i = NN_ET_SWITCH_STATS_LEN * 2; i < NN_ET_GLOBAL_STATS_LEN; i++)
-		ethtool_sprintf(&data, nfp_net_et_stats[i].name);
+		ethtool_puts(&data, nfp_net_et_stats[i].name);
 
 	for (i = 0; i < num_vecs; i++) {
 		ethtool_sprintf(&data, "rxq_%u_pkts", i);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index 9859a4432985..1f6022fb7679 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -258,10 +258,10 @@ static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
 	int i, q_num;
 
 	for (i = 0; i < IONIC_NUM_LIF_STATS; i++)
-		ethtool_sprintf(buf, ionic_lif_stats_desc[i].name);
+		ethtool_puts(buf, ionic_lif_stats_desc[i].name);
 
 	for (i = 0; i < IONIC_NUM_PORT_STATS; i++)
-		ethtool_sprintf(buf, ionic_port_stats_desc[i].name);
+		ethtool_puts(buf, ionic_port_stats_desc[i].name);
 
 	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_tx_strings(lif, buf, q_num);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index ddc5f6d20b9c..6e9e5f01c152 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -75,7 +75,7 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p, wx_gstrings_stats[i].stat_string);
+			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
 		for (i = 0; i < netdev->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 706ea5263e87..1e2fa0ec2327 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1582,10 +1582,10 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ARRAY_SIZE(netvsc_stats); i++)
-			ethtool_sprintf(&p, netvsc_stats[i].name);
+			ethtool_puts(&p, netvsc_stats[i].name);
 
 		for (i = 0; i < ARRAY_SIZE(vf_stats); i++)
-			ethtool_sprintf(&p, vf_stats[i].name);
+			ethtool_puts(&p, vf_stats[i].name);
 
 		for (i = 0; i < nvdev->num_chn; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index a71399965142..2c263ae44b4f 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -415,7 +415,7 @@ static void tja11xx_get_strings(struct phy_device *phydev, u8 *data)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
-		ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].string);
+		ethtool_puts(&data, tja11xx_hw_stats[i].string);
 }
 
 static void tja11xx_get_stats(struct phy_device *phydev,
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 1c7306a1af13..150aea7c9c36 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -508,7 +508,7 @@ static void smsc_get_strings(struct phy_device *phydev, u8 *data)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(smsc_hw_stats); i++)
-		ethtool_sprintf(&data, "%s", smsc_hw_stats[i].string);
+		ethtool_puts(&data, smsc_hw_stats[i].string);
 }
 
 static u64 smsc_get_stat(struct phy_device *phydev, int i)
diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index 98c22d7d87a2..8f5f202cde39 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -245,20 +245,20 @@ vmxnet3_get_strings(struct net_device *netdev, u32 stringset, u8 *buf)
 
 	for (j = 0; j < adapter->num_tx_queues; j++) {
 		for (i = 0; i < ARRAY_SIZE(vmxnet3_tq_dev_stats); i++)
-			ethtool_sprintf(&buf, vmxnet3_tq_dev_stats[i].desc);
+			ethtool_puts(&buf, vmxnet3_tq_dev_stats[i].desc);
 		for (i = 0; i < ARRAY_SIZE(vmxnet3_tq_driver_stats); i++)
-			ethtool_sprintf(&buf, vmxnet3_tq_driver_stats[i].desc);
+			ethtool_puts(&buf, vmxnet3_tq_driver_stats[i].desc);
 	}
 
 	for (j = 0; j < adapter->num_rx_queues; j++) {
 		for (i = 0; i < ARRAY_SIZE(vmxnet3_rq_dev_stats); i++)
-			ethtool_sprintf(&buf, vmxnet3_rq_dev_stats[i].desc);
+			ethtool_puts(&buf, vmxnet3_rq_dev_stats[i].desc);
 		for (i = 0; i < ARRAY_SIZE(vmxnet3_rq_driver_stats); i++)
-			ethtool_sprintf(&buf, vmxnet3_rq_driver_stats[i].desc);
+			ethtool_puts(&buf, vmxnet3_rq_driver_stats[i].desc);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(vmxnet3_global_stats); i++)
-		ethtool_sprintf(&buf, vmxnet3_global_stats[i].desc);
+		ethtool_puts(&buf, vmxnet3_global_stats[i].desc);
 }
 
 netdev_features_t vmxnet3_fix_features(struct net_device *netdev,

-- 
2.43.0.rc2.451.g8631bc7472-goog


