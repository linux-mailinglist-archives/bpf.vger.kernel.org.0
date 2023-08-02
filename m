Return-Path: <bpf+bounces-6657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A595676C2DE
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF54281B20
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608CDA5A;
	Wed,  2 Aug 2023 02:26:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D417E;
	Wed,  2 Aug 2023 02:26:06 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44263213E;
	Tue,  1 Aug 2023 19:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5NLryEdxf13000qvb3gBSk1wrHZaiOT4zyIBgI2rAr9DAN2JFAwTpPsZG7W6ECSKHNXAsj0Ktc+mV01ESb6vYpsjn0a2wqm2x2MqPbU+nmuRlstGJP1txfcewhIP1nPFbZUJ4VvajRdOtNuShzqS3TgHwjUhLQbLiN2sqL6LQ/tq6HvccYOTwhpL11f5t9PgISsfc1AmpOvRjk7jJHTbKSG8Cy/gPR0plWLef6IMlAWrjT5/N5EBwSNdXeNDY50+i1/L2LfiwCiB6iFEql13hRXgV4rNrwJZzUBAB8LmUt5iI6zL7fEVaNZqVjr4Awkz/6trnwIixPQ0gKdASSaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfZ6pgHYxcXHZpHNxZX/cWpN1DQOiOeC1H4AZA0U12Q=;
 b=bVZjlscscQfuPiaOsrqOHOq9+DhMMv/DAj3zF0EhroA5Hh2GKvfFSZ1to3VTc3jjOqwqtdX+o/wyUkYMBPYO5Zk4OdZIqPPZMSGU1XiCewciZjmuTLYBWOevLvIchq1XFZjwnx4MBoK7t8zuAxWm/YHe10Y5asgTYwgEJFtCs6yogiiWuXuC2em+Ecol29tmbABdM7nMoIYjZPY3Ja4jyxEABdJE9HayhakRwy1tibEPWDgFvZVwbnnEBHcEsvTy8Llcdr82rnhjDDpFmBIsY7h4NDQ2jZv9BRcV7cTkleRPk+u2Qsx+TyraA3JBJlHO83GgCsi9JdG+84qmxbHJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfZ6pgHYxcXHZpHNxZX/cWpN1DQOiOeC1H4AZA0U12Q=;
 b=I6PJOBljYLDdVIBcco/VcrWlrKV22KkeuugJ2D0pf2W0dOHlcozQDBMg9myqRGOuJ5Br4JHtBQeFSBgud4oTpzMTDuVNiK0Tn2mltAYyqoDpIqzZiJw6iAtEr7BRRkzHbTDu5useunesrmPz2Z8dNkcRGzW9mT6r0tWMQs5+iJk=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DBBPR04MB7964.eurprd04.prod.outlook.com (2603:10a6:10:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 02:26:02 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 02:26:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, "ast@kernel.org" <ast@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"amritha.nambiar@intel.com" <amritha.nambiar@intel.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"j.vosburgh@gmail.com" <j.vosburgh@gmail.com>, "andy@greyhouse.net"
	<andy@greyhouse.net>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"akiyano@amazon.com" <akiyano@amazon.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
	"dmichail@fungible.com" <dmichail@fungible.com>, "jeroendb@google.com"
	<jeroendb@google.com>, "pkaligineedi@google.com" <pkaligineedi@google.com>,
	"shailend@google.com" <shailend@google.com>, "jesse.brandeburg@intel.com"
	<jesse.brandeburg@intel.com>, "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>, "horatiu.vultur@microchip.com"
	<horatiu.vultur@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "grygorii.strashko@ti.com"
	<grygorii.strashko@ti.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "gerhard@engleder-embedded.com"
	<gerhard@engleder-embedded.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH bpf-next 1/3] eth: add missing xdp.h includes in drivers
Thread-Topic: [PATCH bpf-next 1/3] eth: add missing xdp.h includes in drivers
Thread-Index: AQHZxNjpYOSjae4rMEqlSZX0mn8Rda/WRlTg
Date: Wed, 2 Aug 2023 02:26:02 +0000
Message-ID:
 <AM5PR04MB3139645760B883F05BDB53CD880BA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230802003246.2153774-1-kuba@kernel.org>
 <20230802003246.2153774-2-kuba@kernel.org>
In-Reply-To: <20230802003246.2153774-2-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DBBPR04MB7964:EE_
x-ms-office365-filtering-correlation-id: 6cc5b725-642a-4dd1-a966-08db92ffd0d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fZhbqfB7jH4zTMt8xZXlxLXYdzduWge14v2CXV3XCcRBRsRyEeuIxv5dB3eONbM8NNfF5WRz3h+YVspkxgetCM06MLNNzMXQ+BOXBRjlyfUvzXX8QUS/K8DuNNsELdFirkZGqaTWHKjxXZrdykCLQbKbLuycFE+D3TMnExz/5ovE2uJEXr5YkClLDk5+/cWSAsmxIjiJuz0L9ehs33d5+dAdBIsxIgvvXbMI1vFQePSAlKy7DPfeA/5BA+FPgbZvy0gti6Pnjda4XYIxeBPNYQQSF6odJw+jDzFuh7mpf+MDnsD00JQfd0MtTwsf6IACrp6Vfc3xOn574RaXjnORWV/qyb5lIDrtkr+5zb5oxTppOYCnEpkQP8yuicayVJyQv8rGLf4TQIY4TMLSYldGXyIhRit/55fP299MEWqHdlDkHeczKw+7FuM6ANeXX1jooqbqjJVOP3l7NuN4fxP9ZX2vkfWRJBoF758Ut7AmN0ZaeT84cc+DfHrrSEeUTIDuIAkoDlalRz4uC7b8t1jN0wGCWr+X4oI4g/A+15VTMBbIfs6KV1Zw/jjpFQhDVce69rY6qLbthNCmEW+PWo/0KdlnKl1uJMfV/0bBkHb2xA3zVTEBm3spgukTQ65FP/qI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(66946007)(2906002)(76116006)(64756008)(66476007)(66446008)(4326008)(66556008)(7696005)(33656002)(478600001)(71200400001)(86362001)(9686003)(45080400002)(186003)(122000001)(38070700005)(26005)(6506007)(38100700002)(110136005)(54906003)(55016003)(41300700001)(52536014)(8936002)(8676002)(5660300002)(44832011)(7416002)(316002)(7406005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UHbhNqSzN/dgXL50/IFQ9ttO0h5XRI0aflt6/PYL21yTSuGZlX5gOEYGxdYj?=
 =?us-ascii?Q?v3gzeFStH1e3IfDjJNimGkN63hrOqS/t113aW+xH6IOLHaKuvx4mMFnrl5cr?=
 =?us-ascii?Q?9pURaqNuip05R5onnp+5hqCnhHeZAshy9DTI7QF/EOqNMIDRA2IszA5mFNcK?=
 =?us-ascii?Q?hIt1MVasNew+2soBAqf8dnFBbYFfSB8J0q6wnZPUo+yHoGB+SrFXXhWhmpT5?=
 =?us-ascii?Q?F6XrN0X41wW6ZsiuZo7WBqk7S+OeVgfWLf/YtMEhLMIVoL7xdnZKJzlJ9N7h?=
 =?us-ascii?Q?+mD1DutKf6qiKsbm82fHShEcRfgVhj0Hv8FUkQBgPncVD1cv0I1CQ751zVnJ?=
 =?us-ascii?Q?nO3T4EHvZhrGZhk/DgAcwzKG2lNh9nOiJkDc53I3l/HGh4m0jPkpXn9mDZdq?=
 =?us-ascii?Q?sjQg43H+cwgl/k2MhhL7HGM7eG8qpviHM33Z4iYk1Of83+ulWyvWEckAecqc?=
 =?us-ascii?Q?bIMRVriCikpKwyEgeWxsgHSUZSCmoVXcQHVGeajXCzF7NmFAEmly+UdyK1rF?=
 =?us-ascii?Q?NQ/bxfJ3G+JB+iUxRuzpEqLbCTiLaD3nnR44CUhotO9k2GmjYJ7c+KwIDaO9?=
 =?us-ascii?Q?thhW/quZIwI7Ma5erO0iCQJDmYsbAf2Omgfn6cXJkHckQxT34Vwbguf2YASc?=
 =?us-ascii?Q?OlS4VDAKNy/aBcnGJ0v5a8oKDeNv5GTCjLtiauf7Y1RS+DfrnF7Am+rMZXaR?=
 =?us-ascii?Q?ZQ602u+J9Lf7W6YjaMhDpLW+Z0dWqzPKG5oP1c9EPvEkKLzvj23gBELpyX78?=
 =?us-ascii?Q?ANGljdojOf57HP29Q7J/fNuxPVPum5O7o0sT/2VYV04BD1A0m1pKRLNce8Xv?=
 =?us-ascii?Q?XXcblj0IEn4pltXQZ7PbF2z+XgwEscK7XwmidNsbcqFHYkad7gY/BtNOKCwM?=
 =?us-ascii?Q?htbgoUCkJloM2GEK/cdiuKuXueYVQ/WutEdYVo/TaGpzwX0Lg/hWb3usevvn?=
 =?us-ascii?Q?c9rHgTn8Cns5vXDhUAaXL6whZwT0z8PRwz2Z9XordiLgh5YKxpie4UHzTi/q?=
 =?us-ascii?Q?8nCuPhfzORajzJ34yqdHEiIayQD1Fbb6JK9eTLNwcy4dlvHYhVQjeC8PWMHB?=
 =?us-ascii?Q?0JipZ/FWS2+n+Z1dbcC/9FD8qgCrgys/vIORIs0M5Ef1s/CZQANz7DAVXX9p?=
 =?us-ascii?Q?6f5BJLz/jIPQ5vYoDXaeMq9+AXqu4rqm5QIgNCgx5hufUYtY+AKwaheKdove?=
 =?us-ascii?Q?lxuxsnkclBGKAS0PvudNm8FNBQaCrtvIUZJQzM62xMMbC4gvHbh8+oCO05n4?=
 =?us-ascii?Q?MLf9AzrsTWIbY+F/Og5TW4X9igD0vuvtIN1zq1g7z2ZuTekI3QOk7KESUzAa?=
 =?us-ascii?Q?NmHmbbwc8xSJP4NufHXRdforZ1Vz7/hwpwlNmUe7sLcLX/7VTS7OA9w8cD4b?=
 =?us-ascii?Q?4AP5Jsk8QPzu9momEJhcpU0n3X1TImRE0UJ0Ygzc6KpcvYq6JRoYtqoM+iiS?=
 =?us-ascii?Q?R6z02PRNIJ/noiIvkfS9dZ03Uwbs67voWbbKW3S3wVYOjJiBoW8iqMyhLOFY?=
 =?us-ascii?Q?jyStXmk/0IeGCW2ysTdH4TaicG2p4hySx5dbQdcWzirBXqL7ewSqdw49laFJ?=
 =?us-ascii?Q?5wibByCVpm0kxvDijX8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc5b725-642a-4dd1-a966-08db92ffd0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 02:26:02.0779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXHQNXD5EeI5S7hXXJfcjt8ZOvkmPBJyJDDDdS1dB7cTJMvNc9Rg7QDkmFtGLUlQIwMw6AzSwqX2TnlctYCRww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Handful of drivers currently expect to get xdp.h by virtue of including
> netdevice.h. This will soon no longer be the case so add explicit include=
s.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: j.vosburgh@gmail.com
> CC: andy@greyhouse.net
> CC: shayagr@amazon.com
> CC: akiyano@amazon.com
> CC: ioana.ciornei@nxp.com
> CC: claudiu.manoil@nxp.com
> CC: vladimir.oltean@nxp.com
> CC: wei.fang@nxp.com
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
> CC: gerhard@engleder-embedded.com
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
>=20
[...]
> diff --git a/drivers/net/ethernet/freescale/fec.h
> b/drivers/net/ethernet/freescale/fec.h
> index 8f1edcca96c4..5a0974e62f99 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -22,6 +22,7 @@
>  #include <linux/timecounter.h>
>  #include <dt-bindings/firmware/imx/rsrc.h>  #include
> <linux/firmware/imx/sci.h>
> +#include <net/xdp.h>
>=20
>  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) ||
> defined(CONFIG_M528x) || \
>      defined(CONFIG_M520x) || defined(CONFIG_M532x) ||
> defined(CONFIG_ARM) || \ diff --git

For fec.h, it looks good to me.
Reviewed-by: Wei Fang <wei.fang@nxp.com>

