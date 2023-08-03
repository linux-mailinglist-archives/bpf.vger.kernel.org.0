Return-Path: <bpf+bounces-6891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0149976F37B
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 21:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC30282361
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 19:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAB825932;
	Thu,  3 Aug 2023 19:34:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1263BC;
	Thu,  3 Aug 2023 19:34:18 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC043C3B;
	Thu,  3 Aug 2023 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691091257; x=1722627257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PAF0RMMEV11NiHv10JtB52cVSZdppNLxEZQTYoTqDAA=;
  b=HcL+D8bFKNi/uKFb3CjFAFtAUG/O2WG0zGTuwxGN2WjkiuXLI03nChCN
   t6DZIMsc51rfJGTuWhTSz3XPmiVRjOWFy4PYwR5mN4V0qXLpZJZD96lZS
   wGH0GKv/WoCHFeSjMZC84I1OlVNTpl2hqQp5IkIetzLLkmxmd+JoFE8tW
   AcSJ2SxxxMCBf0bbRgrTG8ywfwVjokgGqphAMbMzxNboBHigbjs2if9HB
   5oLB2LNoGpmyEG4DMyTm0ZVjN/sc1j1N33aNU6ffExBGs+EgMH4O5GdoC
   UsUIRg/wokMmtkpXzwnTjy+CedDRuykZBLekCYCT1cXcNQn7+f7U0KgC/
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="227904296"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2023 12:34:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 3 Aug 2023 12:34:08 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 3 Aug 2023 12:34:08 -0700
Date: Thu, 3 Aug 2023 21:34:07 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <ast@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<hawk@kernel.org>, <amritha.nambiar@intel.com>,
	<aleksander.lobakin@intel.com>, Wei Fang <wei.fang@nxp.com>, Gerhard Engleder
	<gerhard@engleder-embedded.com>, <j.vosburgh@gmail.com>,
	<andy@greyhouse.net>, <shayagr@amazon.com>, <akiyano@amazon.com>,
	<ioana.ciornei@nxp.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<shenwei.wang@nxp.com>, <xiaoning.wang@nxp.com>, <linux-imx@nxp.com>,
	<dmichail@fungible.com>, <jeroendb@google.com>, <pkaligineedi@google.com>,
	<shailend@google.com>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, <UNGLinuxDriver@microchip.com>,
	<kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
	<decui@microsoft.com>, <peppe.cavallaro@st.com>,
	<alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<mcoquelin.stm32@gmail.com>, <grygorii.strashko@ti.com>,
	<longli@microsoft.com>, <sharmaajay@microsoft.com>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <simon.horman@corigine.com>, <leon@kernel.org>,
	<linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/3] eth: add missing xdp.h includes in
 drivers
Message-ID: <20230803193407.ehslw4aar6gknttf@soft-dev3-1>
References: <20230803010230.1755386-1-kuba@kernel.org>
 <20230803010230.1755386-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230803010230.1755386-2-kuba@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The 08/02/2023 18:02, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Handful of drivers currently expect to get xdp.h by virtue
> of including netdevice.h. This will soon no longer be the case
> so add explicit includes.
> 
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> ---
> v2: try a little harder with the alphabetic order of includes
> 
> CC: j.vosburgh@gmail.com
> CC: andy@greyhouse.net
> CC: shayagr@amazon.com
> CC: akiyano@amazon.com
> CC: ioana.ciornei@nxp.com
> CC: claudiu.manoil@nxp.com
> CC: vladimir.oltean@nxp.com
> CC: shenwei.wang@nxp.com
> CC: xiaoning.wang@nxp.com
> CC: linux-imx@nxp.com
> CC: dmichail@fungible.com
> CC: jeroendb@google.com
> CC: pkaligineedi@google.com
> CC: shailend@google.com
> CC: jesse.brandeburg@intel.com
> CC: anthony.l.nguyen@intel.com
> CC: horatiu.vultur@microchip.com
> CC: UNGLinuxDriver@microchip.com
> CC: kys@microsoft.com
> CC: haiyangz@microsoft.com
> CC: wei.liu@kernel.org
> CC: decui@microsoft.com
> CC: peppe.cavallaro@st.com
> CC: alexandre.torgue@foss.st.com
> CC: joabreu@synopsys.com
> CC: mcoquelin.stm32@gmail.com
> CC: grygorii.strashko@ti.com
> CC: longli@microsoft.com
> CC: sharmaajay@microsoft.com
> CC: daniel@iogearbox.net
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: simon.horman@corigine.com
> CC: leon@kernel.org
> CC: linux-hyperv@vger.kernel.org
> CC: bpf@vger.kernel.org
> ---
>  drivers/net/bonding/bond_main.c                       | 1 +
>  drivers/net/ethernet/amazon/ena/ena_netdev.h          | 1 +
>  drivers/net/ethernet/engleder/tsnep.h                 | 1 +
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h      | 1 +
>  drivers/net/ethernet/freescale/enetc/enetc.h          | 1 +
>  drivers/net/ethernet/freescale/fec.h                  | 1 +
>  drivers/net/ethernet/fungible/funeth/funeth_txrx.h    | 1 +
>  drivers/net/ethernet/google/gve/gve.h                 | 1 +
>  drivers/net/ethernet/intel/igc/igc.h                  | 1 +
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.h | 1 +
>  drivers/net/ethernet/microsoft/mana/mana_en.c         | 1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h          | 1 +
>  drivers/net/ethernet/ti/cpsw_priv.h                   | 1 +
>  drivers/net/hyperv/hyperv_net.h                       | 1 +
>  drivers/net/tap.c                                     | 1 +
>  include/net/mana/mana.h                               | 2 ++
>  16 files changed, 17 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7a0f25301f7e..2f21cca4fdaf 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -90,6 +90,7 @@
>  #include <net/tls.h>
>  #endif
>  #include <net/ip6_route.h>
> +#include <net/xdp.h>
> 
>  #include "bonding_priv.h"
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
> index 248b715b4d68..33c923e1261a 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
> @@ -14,6 +14,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
> +#include <net/xdp.h>
>  #include <uapi/linux/bpf.h>
> 
>  #include "ena_com.h"
> diff --git a/drivers/net/ethernet/engleder/tsnep.h b/drivers/net/ethernet/engleder/tsnep.h
> index 11b29f56aaf9..6e14c918e3fb 100644
> --- a/drivers/net/ethernet/engleder/tsnep.h
> +++ b/drivers/net/ethernet/engleder/tsnep.h
> @@ -14,6 +14,7 @@
>  #include <linux/net_tstamp.h>
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/miscdevice.h>
> +#include <net/xdp.h>
> 
>  #define TSNEP "tsnep"
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
> index d56d7a13262e..bfb6c96c3b2f 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
> @@ -12,6 +12,7 @@
>  #include <linux/fsl/mc.h>
>  #include <linux/net_tstamp.h>
>  #include <net/devlink.h>
> +#include <net/xdp.h>
> 
>  #include <soc/fsl/dpaa2-io.h>
>  #include <soc/fsl/dpaa2-fd.h>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 8577cf7699a0..7439739cd81a 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -11,6 +11,7 @@
>  #include <linux/if_vlan.h>
>  #include <linux/phylink.h>
>  #include <linux/dim.h>
> +#include <net/xdp.h>
> 
>  #include "enetc_hw.h"
> 
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 8f1edcca96c4..5a0974e62f99 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -22,6 +22,7 @@
>  #include <linux/timecounter.h>
>  #include <dt-bindings/firmware/imx/rsrc.h>
>  #include <linux/firmware/imx/sci.h>
> +#include <net/xdp.h>
> 
>  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
>      defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
> diff --git a/drivers/net/ethernet/fungible/funeth/funeth_txrx.h b/drivers/net/ethernet/fungible/funeth/funeth_txrx.h
> index 53b7e95213a8..5eec552a1f24 100644
> --- a/drivers/net/ethernet/fungible/funeth/funeth_txrx.h
> +++ b/drivers/net/ethernet/fungible/funeth/funeth_txrx.h
> @@ -5,6 +5,7 @@
> 
>  #include <linux/netdevice.h>
>  #include <linux/u64_stats_sync.h>
> +#include <net/xdp.h>
> 
>  /* Tx descriptor size */
>  #define FUNETH_SQE_SIZE 64U
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 4b425bf71ede..a31256f70348 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -11,6 +11,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
>  #include <linux/u64_stats_sync.h>
> +#include <net/xdp.h>
> 
>  #include "gve_desc.h"
>  #include "gve_desc_dqo.h"
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 9db384f66a8e..4bffc3cb502f 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -15,6 +15,7 @@
>  #include <linux/net_tstamp.h>
>  #include <linux/bitfield.h>
>  #include <linux/hrtimer.h>
> +#include <net/xdp.h>
> 
>  #include "igc_hw.h"
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> index 27f272831ea5..eb7d81b5e9f8 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> @@ -14,6 +14,7 @@
>  #include <net/pkt_cls.h>
>  #include <net/pkt_sched.h>
>  #include <net/switchdev.h>
> +#include <net/xdp.h>
> 
>  #include <vcap_api.h>
>  #include <vcap_api_client.h>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index ac2acc9aca9d..21665f114fe9 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -11,6 +11,7 @@
> 
>  #include <net/checksum.h>
>  #include <net/ip6_checksum.h>
> +#include <net/xdp.h>
> 
>  #include <net/mana/mana.h>
>  #include <net/mana/mana_auxiliary.h>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 4ce5eaaae513..a6d034968654 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -22,6 +22,7 @@
>  #include <linux/net_tstamp.h>
>  #include <linux/reset.h>
>  #include <net/page_pool.h>
> +#include <net/xdp.h>
>  #include <uapi/linux/bpf.h>
> 
>  struct stmmac_resources {
> diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
> index 34230145ca0b..0e27c433098d 100644
> --- a/drivers/net/ethernet/ti/cpsw_priv.h
> +++ b/drivers/net/ethernet/ti/cpsw_priv.h
> @@ -6,6 +6,7 @@
>  #ifndef DRIVERS_NET_ETHERNET_TI_CPSW_PRIV_H_
>  #define DRIVERS_NET_ETHERNET_TI_CPSW_PRIV_H_
> 
> +#include <net/xdp.h>
>  #include <uapi/linux/bpf.h>
> 
>  #include "davinci_cpdma.h"
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> index c9dd69dbe1b8..810977952f95 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -16,6 +16,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/rndis.h>
>  #include <linux/jhash.h>
> +#include <net/xdp.h>
> 
>  /* RSS related */
>  #define OID_GEN_RECEIVE_SCALE_CAPABILITIES 0x00010203  /* query only */
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 9137fb8c1c42..b196a2a54355 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -22,6 +22,7 @@
>  #include <net/net_namespace.h>
>  #include <net/rtnetlink.h>
>  #include <net/sock.h>
> +#include <net/xdp.h>
>  #include <linux/virtio_net.h>
>  #include <linux/skb_array.h>
> 
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 024ad8ddb27e..1ccdca03e166 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -4,6 +4,8 @@
>  #ifndef _MANA_H
>  #define _MANA_H
> 
> +#include <net/xdp.h>
> +
>  #include "gdma.h"
>  #include "hw_channel.h"
> 
> --
> 2.41.0
> 

-- 
/Horatiu

